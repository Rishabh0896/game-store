# Setup Guide

## Prerequisite Software

Before you proceed with the installation, make sure you have the following software installed on your system:

- **Python:** Check if Python is installed by running the command `python --version` in the command prompt (Windows) or terminal (mac/Linux).
- **Pip:** Verify the presence of Pip by running the command `pip --version` in the command prompt or terminal. (You can visit https://pip.pypa.io/en/stable/installation/ for detailed steps on installation)
- **MySqL**

## Installation Steps

1. **Database Setup:**
   - Import the provided dump into your MySQL database. This action will create the database 'game_store_db' along with all necessary tables, procedures, functions, triggers, and data.

2. **Configure Database Connection:**
   - Navigate to the 'gameStore' folder and open the 'settings.py' file using any text editor.
     - Locate the 'DATABASES' variable and update the following values:
       - `USER`: < Root Username for MySQL Workbench (usually 'root') >
       - `PASSWORD`: < Password for the root user of MySQL >
       - `PORT`: < Port where MySQL starts, typically 3306 >

3. **Navigate to Project Directory:**
   - Return to the project directory (the folder containing this readme file).

4. **Install Project Requirements:**
   - Open the command prompt (Windows) or terminal (mac/Linux) and run the following command to install all project requirements:
     ```
     pip install -r requirements.txt
     ```

5. **Run Django Project:**
   - Execute the following command in the command prompt or terminal:
     ```
     python manage.py runserver
     ```

6. **Access Project Dashboard:**
   - Visit the following link in your web browser:
     - [http://127.0.0.1:8000/](http://127.0.0.1:8000/) or [http://localhost:8000/](http://localhost:8000/)


## Exploring the Project

We've made it easy for you to navigate and enjoy the shopping experience. Here's a guide to get you started:

### Project Dashboard

Visit [http://127.0.0.1:8000/](http://127.0.0.1:8000/) or [http://localhost:8000/](http://localhost:8000/) to access the project dashboard. This is where you can explore the games available in the store.

### User Groups and Demo Accounts

We've set up demo accounts for each user group to help you test different functionalities:

1. **Customer:**
   - ID: testCustomer
   - Password: testPassword

2. **Staff:**
   - ID: testStaff
   - Password: testPassword

3. **Manager:**
   - ID: testManager
   - Password: testPassword

### User Login

Visit [Login](http://localhost:8000/login) to log in with any of the demo accounts mentioned above. Alternatively, you can create your own user (with the user group 'Customer') by clicking on [Register](http://localhost:8000/register/).

### User Roles and Actions

#### Customer:
- Explore the dashboard and purchase games.
- Add games to your cart, proceed to checkout, and manage your transaction details, including credit card and address information.
- Review games and provide ratings.
- Navigate to your profile to manage your username, profile image, and more.

#### Staff:
- Perform CRUD operations on game items displayed to users. You have access to CRUD the following entities:
  - GameItem (Table: gameitem)
  - Publisher (Table: publisher)
  - Designer (Table: designer)
  - GameType (Table: game_type)
  - GameMechanic (Table: game_mechanic)

#### Manager:
- Fulfill pending orders.
- View the overall performance of the store through visualizations.

Please refer to the FinalReport.pdf for detaile activity diagrams!

### Visualizations

You'll find that the manager role comes with a set of insightful visualizations to provide key business insights. Here's a brief overview:

#### Popular and Grossing Games

- 🔒 **Access:** Manager Login Required
- **Visualization:** Discover the most popular and top-grossing games.
- **Location:** [Performance](http://127.0.0.1:8000/game_leaderboard/)

#### Total Orders Overview (Pie Chart)

- 🔒 **Access:** Manager Login Required
- **Visualization:** Explore a pie chart overview of total orders.
- **Location:** [Manager Dashboard](http://127.0.0.1:8000/manager_dashboard/)


### Supported CRUD Operations Overview


We've designed the project to seamlessly support various CRUD (Create, Read, Update, Delete) operations across multiple entities. 

| Entity                      | Table                | Create | Read | Update | Delete |
|-----------------------------|----------------------|--------|------|--------|--------|
| Users and Profile           | auth_user, users_profile | ✔ | ✔ | ✔ |  |
| GameItem                    | gameitem             | ✔ | ✔ | ✔ | ✔ |
| Publisher                   | publisher            | ✔ | ✔ | ✔ | ✔ |
| Designer                    | designer             | ✔ | ✔ | ✔ | ✔ |
| GameType                    | game_type            | ✔ | ✔ | ✔ | ✔ |
| GameMechanic                | game_mechanic        | ✔ | ✔ | ✔ | ✔ |
| Order                       | order_item           | ✔ | ✔ |   | ✔ |
| Review                      | review               | ✔ | ✔ | ✔ | ✔ |
| Address                     | address              | ✔ | ✔ | ✔ | ✔ |
| Credit Card                 | credit_card          | ✔ | ✔ | ✔ | ✔ |


Here's a more descrptive view of each of the above CRUD operations available:
We've designed our project to seamlessly support CRUD (Create, Read, Update, Delete) operations across various entities. Below is a detailed summary:

#### Users and Profile (Tables: auth_user, users_profile):
🔒 **Access:** Customer Login Required

- **Create:** Add new users to the system by [registering here](http://localhost:8000/register/).
- **Read and Update:** Retrieve and modify user [profile information](http://127.0.0.1:8000/profile/).

#### GameItem (Table: gameitem):
🔒 **Access:** Staff Login Required

- **Create, Read, Update, Delete:** Manage game items through the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### Publisher (Table: publisher):
🔒 **Access:** Staff Login Required

- **Create, Read, Update, Delete:** Handle publishers in the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### Designer (Table: designer):
🔒 **Access:** Staff Login Required

- **Create, Read, Update, Delete:** Control designers via the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### GameType (Table: game_type):
🔒 **Access:** Staff Login Required

- **Create, Read, Update, Delete:** Manage game types in the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### GameMechanic (Table: game_mechanic):
🔒 **Access:** Staff Login Required

- **Create, Read, Update, Delete:** Oversee game mechanics through the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### Order (Table: order_item):
🔒 **Access:** Customer Login Required

- **Create, Read, Update, Delete:** Handle orders via the [Staff Dashboard](http://127.0.0.1:8000/staff-dashboard/).

#### Review (Table: review):
🔒 **Access:** Customer Login Required

- **Create:** Submit new game reviews through the dashboard.
- **Read, Update, Delete:** Manage reviews in the [Account section](http://127.0.0.1:8000/account/).

#### Address (Table: address):
🔒 **Access:** Customer Login Required

- **Create, Read, Update, Delete:** Control addresses through the [Account section](http://127.0.0.1:8000/account/).

#### Credit Card (Table: credit_card):
🔒 **Access:** Customer Login Required

- **Create, Read, Update, Delete:** Manage credit cards in the [Account section](http://127.0.0.1:8000/account/).

This overview provides a comprehensive understanding of the CRUD operations available for different entities in our project. If you have any questions or need further clarification, please refer to the documentation or reach out for assistance.









## Technical Specifications

Below, we've outlined the key technical details to help you understand how everything works.

### Framework and Database

Our project is built on Django 4.2.7, a powerful Python web framework. It seamlessly connects with MySQL databases, providing a robust foundation for your application. You can run the project on any operating system, as most libraries are either native to Python or fetched via CDN (like Bootstrap) upon opening.

### Dependencies

To ensure smooth operation, we've included various dependencies in the requirements.txt and the same should be installed at Step 4. Here's a breakdown of each, along with its specific purpose:

- **asgiref==3.7.2:** Essential for internal Django functionality.
- **cffi==1.16.0:** Another internal requirement for Django.
- **crispy-bootstrap4==2023.1:** Enhances form rendering in Django using Bootstrap 4.
- **cryptography==41.0.7:** Handles the secure storage and retrieval of user passwords.
- **distlib==0.3.7:** Internal Django requirement.
- **Django==4.2.7:** The core Django framework.
- **django-crispy-forms==2.1:** Simplifies form creation in Django.
- **django-filter==23.4:** Internal Django requirement for advanced filtering.
- **filelock==3.12.4:** Internal Django requirement for file locking.
- **mysql-connector-python==8.2.0:** Connector for MySQL databases.
- **Pillow==10.1.0:** Facilitates fetching and uploading of images in Django applications.
- **platformdirs==3.10.0:** Internal Django requirement for platform-specific directories.
- **protobuf==4.21.12:** Internal Django requirement.
- **pycparser==2.21:** Internal Django requirement.
- **PyMySQL==1.1.0:** Connector for MySQL databases.
- **sqlparse==0.4.4:** Internal Django requirement for SQL parsing.
- **tzdata==2023.3:** Internal Django requirement for time zone data.
- **virtualenv==20.24.5:** Sets up a virtual environment, especially useful for PyCharm users.


