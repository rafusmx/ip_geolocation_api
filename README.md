# Demo API with IPs, URLs and localization data

Tiny API project...

## Setup

The application has some basic Docker configuration that let's you play with it without setting up the whole environment manually. To get it up an running use.

'''
docker-compose build
docker-compose up
'''

> This should run db:prepare and get the db populated with some information
> If the database doesn't get populated you can alternatively populate it using
> `docker-compose run api rails db:setup`

## Use

Considering that the app is running locally on a docker container. The API should work on the localhost

### Base URL
`http://localhost:3000/location_data`

#### Basic lookup

| Params | Description |
|--------|:------------|
| `address` | The request address could be an IPv4 or IPv6 address, or alternatively an URL as in the example. |

GET: `http://localhost:3000/location_data?address=http://google.com`

Response:

```
{
  "url": "google.com",
  "ip": "192.0.77.48",
  "type": "ipv4",
  "location_data": {
    "latitude": "33.97785186767578",
    "longitude": "-118.44526672363281",
    "continent": "North America",
    "country": "United States",
    "region": "California",
    "zip": "90292"
  }
}
```
#### Item creation

| Params | Description |
|--------|:------------|
| `address` | The request address could be an IPv4 or IPv6 address, or alternatively an URL as in the example. |
| `latitude` | Latitude |
| `longitude` | Longitude |
| `continent` | Name of the continent where the IP belongs |
| `country` | Name of the country |
| `region` | Name of the region |
| `zip` | Zip Code or Postal Code |

###### Only the address is required to create a new item.

POST: `http://localhost:3000/location_data?address=https://google.com&latitude=33.97785186767578&longitude=-118.44526672363281&continent=North America&country=United States&region=California&zip=90292`

Response:
```
{
  "url": "google.com",
  "ip": "192.178.56.46",
  "type": "ipv4",
  "location_data": {
    "latitude": "33.97785186767578",
    "longitude": "-118.44526672363281",
    "continent": "North America",
    "country": "United States",
    "region": "California",
    "zip": "90292"
  }
}
```

#### Item deletion

| Params | Description |
|--------|:------------|
| `address` | The request address could be an IPv4 or IPv6 address, or alternatively an URL as in the example. |

DELETE: `http://localhost:3000/location_data?address=http://google.com`

Response:
```
{
  "message": "Successfully removed records",
  "address": "https://google.com"
}
```


## ToDos

- Add an autofill option that allows the user to send a request with an address and a flag to pull data from a 3rd party API.
- Add support for URLs without `http://` or `https://` prefixes.
- Imprpove URL validation
- Add support for IPs with prefixes.
- Add access control and API keys.
- Add some cache functionality.
- Add support for bulk requests.
