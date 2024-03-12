# 📚 FRNSHR

Bootcamp final group project.
FRNSHR is an interior design tool which helps you find suitable furniture from several websites (like IKEA or FrancFranc) to decorate your space based on a specific color scheme.

![Capture d'écran 2024-03-11 124618](https://github.com/Jasufr/FRNSHR/assets/125636129/b8105e45-c5bf-42b5-9c57-6b7f84c8400a)
![Capture d'écran 2024-03-11 124747](https://github.com/Jasufr/FRNSHR/assets/125636129/fa7d8695-007d-4df5-9154-683164e78171)
![Capture d'écran 2024-03-11 124831](https://github.com/Jasufr/FRNSHR/assets/125636129/5daa5707-c970-4162-8108-7f8124d45646)


<br>
App home: https://www.frnshr.shop/
   

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Acknowledgements
Inspired by Jane Mount's [Bibliophile](https://www.amazon.com/Bibliophile-Illustrated-Miscellany-Jane-Mount/dp/1452167230) and a story my father once told me: "Why do we keep books? ... We keep books because they remind us of the new perspectives and lessons we learned".

## Team Members
- [Ruby Tam](https://github.com/rubykytam)
- [Nick Westbrook](https://github.com/ntw3001)
- [Nikita Nagras](https://github.com/Nikita-Nagras)
- [Justin Etienne](https://github.com/Jasufr)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License
