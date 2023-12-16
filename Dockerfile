FROM oraclelinux:latest

# Create a non-root user with a specific UID and GID
RUN groupadd -g 1000 prime && \
    useradd -m -u 1000 -g 1000 prime

# Set the password for the user (replace 'password' with the actual password)
RUN echo 'prime:password' | chpasswd

RUN chown root:root /etc/ssh/sshd_config
RUN chmod 644 /etc/ssh/sshd_config

# Switch to the non-root user
USER prime

# Set the working directory for the user
WORKDIR /home/prime

# Copy files or perform other tasks as the non-root user

# Example: Copy the SSH public key to the user's authorized_keys file
COPY ./ssh/id_rsa.pub /home/prime/.ssh/authorized_keys
COPY ./ssh/id_rsa /etc/ssh/ssh_host_rsa_key

USER root
RUN chown -R prime:prime /home/prime/.ssh

# Specify the command to run when the container starts
CMD ["tail", "-f", "/dev/null"]
