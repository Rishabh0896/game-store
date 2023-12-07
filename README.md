# Project Setup Guide

## Prerequisite Software

Before you proceed with the installation, make sure you have the following software installed on your system:

- **Python:** Check if Python is installed by running the command `python --version` in the command prompt (Windows) or terminal (mac/Linux).
- **Pip:** Verify the presence of Pip by running the command `pip --version` in the command prompt or terminal. (You can visit https://pip.pypa.io/en/stable/installation/ for detailed steps on installation)
- **MySqL**

## Installation Steps

1. **Database Setup:**
   - Import the provided dump into your MySQL database. This action will create the database 'game_store_db_ver3' along with all necessary tables, procedures, functions, triggers, and data.

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

## Exploring the project

We have built a complete end to end game-store using Django and MySql.
To navigate to the 