# HotelUp

HotelUp is a hotel management system that allows clients to book their reservations nad hotel staff to manage their tasks. The system is built using:
- .NET 8 - backend API
- Python 3.9 - backend API
- React 19 - frontend
- PostgreSQL - database
- Docker - containerization
- Kubernetes - orchestration
- AWS - cloud services
- Terraform - infrastructure as code
- Github Actions - CI/CD

## Modules

### [HotelUp.Frontend](https://github.com/Wiaz24/HotelUp.Frontend)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Frontend)

This module is responsible for the user interface of the system. It allows customers to book their reservations and hotel staff to manage their tasks.

### [HotelUp.Customer](https://github.com/Wiaz24/HotelUp.Customer)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Customer)

This service is responsible for managing customer reservations and room creation. Customer or receptionist can create new reservations, cancel them, and admin can create new rooms.

### [HotelUp.Cleaning](https://github.com/Wiaz24/HotelUp.Cleaning)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Cleaning)

This service is responsible for managing cleaning tasks in the hotel. Customer or receptionist can create cleaning tasks that generate additional cost. Cleaners can manage their tasks and mark them as done.

### [HotelUp.Employee](https://github.com/Wiaz24/HotelUp.Employee)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Employee)

This service is responsible for managing hotel staff. Admin can create new employees with different roles.

### [HotelUp.Information](https://github.com/Wiaz24/HotelUp.Information)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Information)

This service is responsible for displaying information about the hotel. It shows available rooms, served meals and hotel events.

### [HotelUp.Kitchen](https://github.com/Wiaz24/HotelUp.Kitchen)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Kitchen)

This service is responsible for managing kitchen tasks in the hotel. Customer or receptionist can create kitchen tasks that generate additional cost. Cooks can manage their tasks and create new meals, menus and publish them.

### [HotelUp.Repair](https://github.com/Wiaz24/HotelUp.Repair)
![Commits](https://badgen.net/github/commits/Wiaz24/HotelUp.Repair)

This service is responsible for managing repair tasks in the hotel. Customer or receptionist can create repair tasks that generate additional cost. Janitors can manage their tasks and generate service reports.