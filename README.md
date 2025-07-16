# Solar Wind 🌤️
## Project overview
**Solar Wind** is a social matching iOS app designed to connect people based on shared sports and fitness interests. Whether you're a casual jogger or a competitive player, Solar Wind helps you find like-minded workout partners in your area with similar schedules and goals.

### 💡 Problem Statement 

Staying consistent with a workout routine is tough — but having a reliable partner makes it easier. Solar Wind solves this by helping users find nearby people with similar fitness goals, interests, and availability. Unlike generic meetup platforms, Solar Wind is focused entirely on building a sport-oriented community with personal matching.

### 👥 Target Users

Young adults (18–30) who want to:

- Stay motivated via social accountability
- Easily find compatible workout partners
- Join an active lifestyle community

###  ⚡Key Features

- **Personalized Matching**: Feed suggests people based on shared sports interests, time availability, and location.
- **Profile Customization**: Add sports, skill levels, and availability.
- **Telegram Integration**: Easily initiate Telegram chats after mutual friendship to coordinate meetups.
- **Community-Oriented**: Encourages local sport meetups and long-term fitness relationships.

## 🧑‍💻 Tech Stack

### Frontend (iOS):
- **UIKit** + **modular SwiftUI** for flexibility and stability
- **Clean Swift** architecture for maintainability
- **Alamofire** for HTTP networking
- **Kingfisher** for image loading and caching

### Backend:
- **Java 23.0**
- **Python 3.12**
- **Spring Boot** for RESTful services
- **Hibernate** for ORM and caching

### Database:
- **PostgreSQL** (primary data storage)
- **Redis** (caching layer)

## 🛠️ How to Run Locally

1. Clone this repo:
```bash
git clone https://github.com/your-username/solar-wind.git
cd solar-wind
```
   
2. For iOS frontend:
- Open ``Solar-Wind-iOS-app/Solar-Wind-iOS-app.xcodeproj/project.xcworkspace`` in Xcode
- In Xcode, go to:
    `File` → `Packages` → `Resolve Package Versions`
To refresh all packages to their latest compatible versions:  
   `File` → `Packages` → `Update to Latest Package Versions`
- Build and run on simulator or device
    
3. For backend:
- Prerequisites: [Docker](https://www.docker.com/products/docker-desktop) and [GNU Make (for Windows)](https://www.gnu.org/software/make/) installed.

```bash
cd backend
make all
```

## 💻 API Specification

Each microservice has its own Swagger UI documentation:

- [🔗Likes Service API](https://solar-wind-gymbro.ru/likes/swagger-ui.html)
- [🔗Profiles Service API](https://solar-wind-gymbro.ru/profiles/swagger-ui.html)
- [🔗Notifications Service API](https://solar-wind-gymbro.ru/notifications/swagger-ui.html)
- [🔗Deck Shuffle Service API](https://solar-wind-gymbro.ru/deckShuffle/swagger-ui.html)

Full Postman collection:
- [🔗Solar Wind API on Postman](https://www.postman.com/grey-satellite-701545/solar-wind/overview)

## 🔁 User Flow Diagrams

The following diagrams illustrate the core user flows in the Solar Wind app:

- [🔗 Registration flow](https://www.figma.com/design/si98563MfBSXuDtOfV8655/FitFlame?node-id=0-1&p=f&t=0YEz2ac3MJ8uvHij-0)
- [🔗 Main flow](https://www.figma.com/design/si98563MfBSXuDtOfV8655/FitFlame?node-id=129-1161&p=f&t=ZYFIR9AQSHxESbqE-0)

## 📝 License
[MIT License](https://github.com/IU-Capstone-Project-2025/Solar-Wind/blob/backend/LICENSE)

##  📩  Contact
For questions or feedback, please contact the team leader at: da.nikolaeva@innopolis.university.
