# REST API

## For help

* For examples we use tool: [httpie](https://httpie.org)
* [Redmine REST API](http://www.redmine.org/projects/redmine/wiki/Rest_api)

## List of commands

* [Projects list](#projects-list)
* [Subscriptions list](#subscriptions-list)
* [Subscription information](#subscription-information)
* [Subscription spend time](#subscription-spend-time)
* [Subscription extra time](#subscription-extra-time)
* [Create subscription](#create-subscription)
* [Delete subscription](#delete-subscription)
* [Edit subscription](#edit-subscription)
* [Add extra time](#add-extra-time)

## Projects list

**request**

```
http --json GET http://172.28.128.3/projects.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
``` 

**reply**

```
{
    "limit": 25,
    "offset": 0,
    "projects": [
        {
            "created_on": "2017-01-31T06:38:33Z",
            "description": "",
            "id": 2,
            "identifier": "ttm-demo",
            "is_public": true,
            "name": "TTM Demo",
            "status": 1,
            "updated_on": "2017-01-31T06:38:33Z"
        },
        {
            "created_on": "2016-12-17T17:05:07Z",
            "description": "",
            "id": 1,
            "identifier": "vault-demo",
            "is_public": true,
            "name": "Vault Demo",
            "status": 1,
            "updated_on": "2016-12-17T17:05:07Z"
        }
    ],
    "total_count": 2
}
```

## Subscriptions list

**request**

```
http --json GET http://172.28.128.3/projects/ttm-demo/subscriptions.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
```

**reply**

```
[
    {
        "activity_id": 1,
        "begindate": "2017-02-01",
        "enddate": "2017-02-28",
        "hours": 20.0,
        "id": 3,
        "name": "Demo subscription",
        "notify_email": "info@noshutdown.ru",
        "project_id": 2,
        "rate": 2.0,
        "tracker_id": 2
    }
]

```

## Subscription information

**request**

```
http --json GET http://172.28.128.3/projects/ttm-demo/subscriptions/3.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
```
**reply**

```
{
    "activity_id": null,
    "begindate": "2017-02-01",
    "enddate": "2017-02-28",
    "hours": 20.0,
    "id": 3,
    "name": "test",
    "notify_email": "info@noshutdown.ru",
    "project_id": 2,
    "rate": 2.0,
    "tracker_id": 2
}
```

## Subscription spend time

**request**

```
http --json GET http://172.28.128.3/projects/ttm-demo/subscriptions/5/time_entries.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
```

**reply**

```
[
    {
        "activity_id": 8,
        "comments": "",
        "created_on": "2017-02-09T19:26:26.128Z",
        "hours": 1.0,
        "id": 1,
        "issue_id": 1,
        "project_id": 2,
        "spent_on": "2017-02-09",
        "tmonth": 2,
        "tweek": 6,
        "tyear": 2017,
        "updated_on": "2017-02-09T19:26:26.128Z",
        "user_id": 1
    },
    {
        "activity_id": 8,
        "comments": "",
        "created_on": "2017-02-09T19:27:40.249Z",
        "hours": 3.33,
        "id": 2,
        "issue_id": 1,
        "project_id": 2,
        "spent_on": "2017-02-09",
        "tmonth": 2,
        "tweek": 6,
        "tyear": 2017,
        "updated_on": "2017-02-09T19:27:40.249Z",
        "user_id": 1
    },
    {
        "activity_id": 8,
        "comments": "",
        "created_on": "2017-02-09T19:27:53.367Z",
        "hours": 0.08,
        "id": 3,
        "issue_id": 1,
        "project_id": 2,
        "spent_on": "2017-02-09",
        "tmonth": 2,
        "tweek": 6,
        "tyear": 2017,
        "updated_on": "2017-02-09T19:27:53.367Z",
        "user_id": 1
    }
]
```

## Subscription extra time

**request**

```
http --json GET http://172.28.128.3/projects/ttm-demo/subscriptions/10/extra_times.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
```

**reply**

```
[
    {
        "date_added": "2017-02-06",
        "hours": 5.0,
        "id": 15,
        "subscription_id": 10
    }
]
```

## Create subscription

**request**

```
 http --json POST http://172.28.128.3/projects/ttm-demo/subscriptions.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f ttm_subscription:='{"name":"Demo subscription","begindate":"2017-02-01","enddate":"2017-02-28","hours": 20.0,"notify_email":"info@noshutdown.ru","rate":2.0,"tracker_id":3,"activity_id":1}'
```

**reply**

```
HTTP/1.1 201 Created
Cache-Control: no-cache
Connection: Keep-Alive
Content-Length: 0
Content-Type: application/json; charset=utf-8
Date: Mon, 06 Feb 2017 20:30:15 GMT
Server: WEBrick/1.3.1 (Ruby/2.3.2/2016-11-15)
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: fee5c4b2-15fe-4885-9a1e-c439215d12ee
X-Runtime: 0.013497
X-Xss-Protection: 1; mode=block
```

## Delete subscription

**request**

```
http --json DELETE http://172.28.128.3/projects/ttm-demo/subscriptions/3.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f
```

**reply**

```
HTTP/1.1 202 Accepted
Cache-Control: no-cache
Connection: Keep-Alive
Content-Length: 0
Content-Type: application/json; charset=utf-8
Date: Tue, 07 Feb 2017 08:05:30 GMT
Server: WEBrick/1.3.1 (Ruby/2.3.2/2016-11-15)
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: fd6b6783-e514-4cd0-96d4-c6ade08e0abd
X-Runtime: 0.013488
X-Xss-Protection: 1; mode=block
```

## Edit subscription

**request**

```
http --json PUT http://172.28.128.3/projects/ttm-demo/subscriptions/5.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f ttm_subscription:='{"name":"new_name"}'
```

**reply**

```
HTTP/1.1 202 Accepted
Cache-Control: no-cache
Connection: Keep-Alive
Content-Length: 0
Content-Type: application/json; charset=utf-8
Date: Tue, 07 Feb 2017 08:21:36 GMT
Server: WEBrick/1.3.1 (Ruby/2.3.2/2016-11-15)
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: 86d8dbb1-1ac5-4175-8296-e2483dfccf21
X-Runtime: 0.013734
X-Xss-Protection: 1; mode=block
```

## Add extra time

**request**

```
http --json POST http://172.28.128.3/projects/ttm-demo/subscriptions/5/extra_times.json key=2759a9e52637fac5180cb8f31586ce4dd5da927f ttm_extra_time:='{"hours": 10}'
```

**reply**

```
HTTP/1.1 201 Created
Cache-Control: no-cache
Connection: Keep-Alive
Content-Length: 0
Content-Type: application/json; charset=utf-8
Date: Tue, 07 Feb 2017 08:33:21 GMT
Server: WEBrick/1.3.1 (Ruby/2.3.2/2016-11-15)
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Request-Id: c8a8b3c4-3cdc-4cc5-9c86-c605970ea8e5
X-Runtime: 0.041968
X-Xss-Protection: 1; mode=block
```
