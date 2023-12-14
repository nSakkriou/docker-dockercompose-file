# WOrks in python 2.7 not sure if it works in python 3.

# Connect, but only using SSL version 2 aor 3
from ftplib import FTP_TLS
import ssl, os

class FTPSender:

    TARGET_FOLDER = "site/wwwroot"
    LOCAL_FILES_FOLDER = "php-example-files"

    def __init__(self, host: str, user: str, password: str) -> None:
        self.host = host
        self.ftp = FTP_TLS(host, user, password)

    def removeAllFiles(self):
        print("Start remove files")
        files = list(self.ftp.nlst(FTPSender.TARGET_FOLDER))
        for f in files:
            if f[-3:] == "/.." or f[-2:] == '/.': continue
            self.ftp.delete(f)
            print("file delete = " + f)

        print("End remove files")

    def sendFiles(self):
        print("Start send files")
        for path in os.listdir(FTPSender.LOCAL_FILES_FOLDER):
            if("php" in path or "html" in path):
                with open(FTPSender.LOCAL_FILES_FOLDER + "/" + path, "rb") as file:

                    print("start file send " + path)
                    self.ftp.storbinary('STOR ' + FTPSender.TARGET_FOLDER + "/" + path, file)
                    print("file send " + path)

        print("End send files")

    def checkFiles(self, folder):
        self.ftp.dir(folder)

    def close(self):
        self.ftp.close()

    def run(host: str, user: str, password: str):
        print("------")
        ftpInstance = FTPSender(host, user, password)
        
        print("Start process host = " + ftpInstance.host)
        print("Start state")
        ftpInstance.checkFiles(FTPSender.TARGET_FOLDER)

        ftpInstance.removeAllFiles()
        ftpInstance.sendFiles()

        print("End process host = " + ftpInstance.host)
        print("Final state")
        ftpInstance.checkFiles(FTPSender.TARGET_FOLDER)

        ftpInstance.close()


if __name__ == "__main__":
    datas = [
        {
            "host": "waws-prod-db3-309.ftp.azurewebsites.windows.net",
            "user" : "app1-app-service\$app1-app-service",
            "password" : "Fyl4AdCSMEbDyilhMXGg0jSow9dEeD07gYsEMSybuEEfDSjc1pfegWSiP1b0"
        },
        {
            "host": "waws-prod-am2-389.ftp.azurewebsites.windows.net",
            "user" : "app2-app-service\$app2-app-service",
            "password" : "huvusBd73o5gRTZi2Clo77sEZJrR1rDn1toHvX02ssxdZpcMhsE0M06n1efj"
        }
    ]


    for data in datas:
        FTPSender.run(data["host"], data["user"], data["password"])