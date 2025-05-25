# HotelBedsClient

**HotelBedsClient** is a Ruby gem that provides a clean, extensible, and Ruby-friendly interface for interacting with the [HotelBeds API](https://developer.hotelbeds.com/). It supports core API operations including hotel availability, rate checking, booking confirmation, and destination queries (some of them are under development and temporary unavailable).

### ✨ Features

- ✅ Configurable API credentials and environment
- 🏨 Hotels list fetching with filtering support
- 📦 Easy integration with booking, availability, and content endpoints *(in progress)*
- 🧩 Built-in methods for using response data without additional parsing
### 📦 Installation

Add this line to your application's Gemfile:

```
gem 'hotel_beds_client', git: 'https://github.com/AndriyAndriyovuch/hotel_beds_client'
```
Then execute:


```
bundle install
```

Or install it yourself with:


```
gem install hotel_beds_client
```

### 🔧 Configuration

Before making API calls, configure the client with your HotelBeds API credentials:


```
HotelBedsClient.configure do |config|
  config.api_key = 'your_api_key'
  config.secret  = 'your_secret'
  config.base_url = 'https://api.test.hotelbeds.com' # default value for development
end
```

### 🚀 Usage Examples

- `hotels_list`

Fetch a list of hotels from the HotelBeds Content API using various filtering and localization options.

##### Parameters
| Parameter              | Type                  | Description |
|------------------------|-----------------------|-------------|
| `destination_code`     | `String`              | Filter results by a specific destination code. Example: `'PMI'`. |
| `country_code`         | `String`              | Filter results by a specific country code. Example: `'US'`. |
| `codes`                | `Array<Integer>`      | Array of specific hotel codes to filter the response by. |
| `include_hotels`       | `String or Array<String>` | Accepts `'webOnly'`, `'notOnSale'`, or both. Use to include special hotel availability groups. Example: `'webOnly,notOnSale'`. |
| `fields`               | `String or Array<String>` | Defines which fields to include in the response. Use `'all'` to fetch all available fields. |
| `language`             | `String`              | Language code for hotel descriptions. Defaults to English if not specified. Example: `'CAS'`. |
| `from`                 | `Integer`             | Index of the first record to return (pagination). Defaults to `1`. |
| `to`                   | `Integer`             | Index of the last record to return (pagination). Defaults to `100`. |
| `use_secondary_language` | `Boolean`          | If `true`, fallback to English for any missing translations in the requested language. |
| `last_update_time`     | `String (YYYY-MM-DD)` | Filter by last updated date. Only hotels updated after this date will be returned. |
| `pms_room_code`        | `Boolean`             | If `true`, only return hotels that include at least one PMS room code. Useful for property-level mapping. |


###### Example Usage
```

response = HotelBedsClient.hotels_list

# or with params

response = HotelBedsClient.hotels_list(
  destination_code: 'PMI',
  country_code: 'ES',
  codes: [123, 456],
  include_hotels: 'webOnly,notOnSale',
  fields: 'all',
  language: 'ENG',
  from: 1,
  to: 100,
  use_secondary_language: true,
  last_update_time: '2024-01-01',
  pms_room_code: true
)

puts response.hotels.first =>
#<HotelBedsClient::HotelContent::HotelsList::Hotel:0x000077481b6ac928

puts response.hotels.first.email
 => "email@gmail.com"
 ```


### 🤝 Contributing
Contributions are welcome and appreciated! 🙌

Whether you're fixing bugs, improving documentation, or adding new features to the hotel_beds_client, your help is invaluable.

🛠 How to Contribute
1. Fork the repo and create your branch from main:

`git checkout -b feature/your-feature-name`

2. Write tests for your changes (if applicable).

3. Commit your changes and push the branch:

4. Open a Pull Request and describe your changes!

`git push origin feature/your-feature-name`

#### ✍️ Contribution Guidelines

- Keep code style clean and consistent
- Prefer readability and maintainability
- Write clear, descriptive commit messages
- Add or update documentation where needed

Thank You!
Every PR, issue, or suggestion helps make this gem better. Let's make hotel integrations a breeze together! 🔨🤖🔧


### 📄 License
This gem is available as open source under the terms of the MIT License.
