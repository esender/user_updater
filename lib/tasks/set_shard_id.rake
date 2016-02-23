require_relative './remaining_time'

namespace :db do
  desc 'Set nulled shard_id field in users table'
  task :set_shard_id, [:start, :batch_size] => :environment do |_, args|
    users_count = UserRepository.empty_shard_id.count
    remaining_time = RemainingTime.new(Time.now, users_count)

    start = args.start.empty? ? nil : args.start.to_i
    batch_size = args.batch_size.empty? ? 1000 : args.batch_size.to_i

    success = 0
    failed = 0

    UserRepository.empty_shard_id_in_batches(start: start, batch_size: batch_size) do |users, batch_num|
      threads = users.map do |user|
        update_user_in_thread(user)
      end
      info_array = threads.map do |t|
        t.join
        t[:info]
      end

      processed = users_count < batch_size ? users_count : batch_size * batch_num
      success += info_array.count { |i| i[:success] }
      failed += processed - success
      r_time = remaining_time.humanized_count(processed)

      print "\r#{processed} / #{users_count} | F: #{failed} | S: #{success} | Remaining Time: #{r_time}"
    end
    puts "\r\nFinished"
  end

  desc 'Seed DB'
  task seed: :environment do |t|
    (1..100_000).each do |_|
      user = User.new
      UserRepository.create(user)
    end
  end

  def logger
    @logger ||= Hanami::Logger.new('set_shard_id')
  end

  def update_user(user)
    info = { success: true, user_id: user.id }
    begin
      user.generate_shard_id
      UserRepository.update(user)
    rescue Exception => e
      info[:success] = false
      logger.error("Can't update user with ID = #{user.id}, error: #{e.message}")
    end
    info
  end

  def update_user_in_thread(user)
    Thread.new(user) do |u|
      Thread.current[:info] = update_user(u)
    end
  end
end
