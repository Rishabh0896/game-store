from django.core.management.base import BaseCommand
from django.conf import settings
import getpass


class Command(BaseCommand):
    help = 'Set MySQL credentials and create database for the Game Store application'

    def handle(self, *args, **options):
        mysql_db_name = input("Enter a name of the database (default is 'prod_game_store_db'): ") \
                        or 'prod_game_store_db'
        mysql_user = input("Enter MySQL username: ")
        mysql_password = getpass.getpass("Enter MySQL password: ")
        mysql_host = input("Enter MySQL hostname (default is 'localhost'): ") or 'localhost'
        mysql_port = input("Enter MySQL port (default is '3306'): ") or '3306'

        settings_path = settings.BASE_DIR / 'gameStore/settings.py'

        # Read the existing settings.py content
        with open(settings_path, 'r') as settings_file:
            settings_content = settings_file.read()

        # Replace placeholders in the DATABASES configuration
        settings_content = settings_content.replace("$$DB_NAME$$", mysql_db_name).replace("$$DB_USER$$", mysql_user).\
            replace("$$DB_PASSWORD$$", mysql_password).replace("$$DB_HOST$$", mysql_host).\
            replace("$$DB_PORT$$", mysql_port)

        # Write the modified content back to settings.py
        with open(settings_path, 'w') as settings_file:
            settings_file.write(settings_content)

        self.stdout.write(self.style.SUCCESS("MySQL credentials updated in settings.py"))
