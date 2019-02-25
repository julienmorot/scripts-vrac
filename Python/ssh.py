#!/usr/bin/env python

import sys
import paramiko
import select


class ParamikoSSH:
    def __init__(self, sshhost, sshuser, sshpass):
        self.host = sshhost
        self.port = 22
        self.user = sshuser
        self.password = sshpass
        self.client = None
        self.ssh_output = []
        self.ssh_error = None
        self.timeout = 10
    def connect(self):
        try:
            self.client = paramiko.SSHClient()
            self.client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            self.client.connect(self.host, port=self.port,username=self.user, password=self.password)
            return True
        except paramiko.AuthenticationException:
            print("Authentication failure")
        except Exception:
            print("Error while connecting to remote server")
            self.client.close()
            return False
    def run(self, command):
        if self.connect():
            try:
                stdin, stdout, stderr = self.client.exec_command(command,timeout=self.timeout)
                exit_status = stdout.channel.recv_exit_status()
                self.ssh_output = stdout.readlines()
                self.ssh_error = stderr.read()
                if self.ssh_error:
                    print("Error : " + self.ssh_error)
                stdin.flush()
                stdin.channel.shutdown_write()
                self.client.close()
                for outline in self.ssh_output:
                    print(outline.strip().decode())
                return True
            except paramiko.SSHException:
                self.client.close()
                return False
        else:
            return False
