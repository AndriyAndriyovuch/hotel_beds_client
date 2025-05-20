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
  config.endpoint = 'https://api.test.hotelbeds.com'
end
```

🚀 Usage Examples

Fetch Hotels List
```
response = HotelBedsClient.hotels_list(
  destination_code: 'PMI',
  country_code: 'ES',
  fields: 'all',
  language: 'ENG',
  from: '2024-07-01',
  to: '2024-07-10'
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
Fork the repo and create your branch from main:


`git checkout -b feature/your-feature-name`

Write tests for your changes (if applicable).

Run tests to make sure everything works:


bundle exec rake
Commit your changes and push the branch:


git push origin feature/your-feature-name
Open a Pull Request and describe your changes!

#### ✍️ Contribution Guidelines

- Keep code style clean and consistent
- Prefer readability and maintainability
- Write clear, descriptive commit messages
- Add or update documentation where needed

Thank You!
Every PR, issue, or suggestion helps make this gem better. Let's make hotel integrations a breeze together! 🔨🤖🔧


### 📄 License
This gem is available as open source under the terms of the MIT License.
