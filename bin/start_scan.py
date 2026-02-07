import hashlib
from random import SystemRandom
import string
import sys
from typing import final
from urllib import request

@final
class Client:
    def __init__(self, host: str, username: str, password: str, ssl: bool=False, api_version: str="1.16.0"):
        self.host = host
        self.username = username
        self.password = password
        self.ssl = ssl
        self.api_version = api_version

    def hash_password(self):
        """
        return random salted md5 hash of password
        """
        characters = string.ascii_uppercase + string.ascii_lowercase + string.digits
        salt = ''.join(SystemRandom().choice(characters) for _ in range(9))
        salted_password = self.password + salt
        token = hashlib.md5(salted_password.encode('utf-8')).hexdigest()
        return token, salt

    def create_url(self, endpoint: str):
        """
        build the standard url for interfacing with the Subsonic REST API
        :param endpoint: REST endpoint to incorporate in the url
        """
        token, salt = self.hash_password()
        url = '{}://{}/rest/{}?u={}&t={}&s={}&v={}&c=pSub&f=json'.format(
            'https' if self.ssl else 'http',
            self.host,
            endpoint,
            self.username,
            token,
            salt,
            self.api_version
        )

        return url

    def make_request(self, url):
        """
        GET the supplied url and resturn the response as json.
        Handle any errors present.
        :param url: full url. see create_url method for details
        :return: Subsonic response or None on failure
        """
        response = request.urlopen(url)

        response_str = response.read()
        print(response_str)

        response.close()
        return response_str


def main():
    username = input("Username: ")
    password = input("Password: ")
    client = Client("music.elj.me", username, password, ssl=True)
    client.make_request(client.create_url("startScan"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
