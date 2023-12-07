import subprocess


def install_requirements():
    print("Installing project requirements...")
    subprocess.run(['pip', 'install', '-r', 'requirements.txt'])
    print("Requirements installation completed.")


def execute_management_command(command):
    print(f"Executing management command: python manage.py {command}")
    process = subprocess.Popen(['python', 'manage.py', command])
    process.wait()  # Wait for the command to complete
    print(f"Management command '{command}' executed.")


def main():
    print("Welcome to the Django Project Setup Script!")
    print("This script will help you set up your Django project.")

    # Install requirements
    install_requirements()

    # Execute management command to set MySQL credentials
    execute_management_command('set_mysql_credentials')
    execute_management_command('run_ddl')
    execute_management_command('run_dml')

    print("Setup script completed. Your Django project is ready to go!")
    print("To start the project, run the following command:")
    print("python manage.py runserver")


if __name__ == "__main__":
    main()
