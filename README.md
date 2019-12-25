**Suppose:**\
Exists very big table `users` with fields: *id*, *shard_id* (> 10 million records)

```
|id |shard_id|
| 1 |NULL    |
| 2 |NULL    |
|...|NULL    |
```

**Need to be done:**\
Set a random value from 1 up to 10 for each NULL valued shard_id field.

Solution should:
- Allows to stop updating at any time, fix the code and run it again, without updating processed data
- Be resilient to exceptions in case of updating individual records
- Scalable. Allows to run it multithreaded
- Should assume and display a potential time of ending
- Work in real production system without stopping the main app

**Optional**/
- Write an API to get number of unprocessed records

```
curl http://localhost:3000/api/sync/users/count
```

Possible to use any library
