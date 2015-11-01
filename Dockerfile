#Import base CentOS 7 image
FROM centos:7

# Expose Xonotic port (defined in server.cfg
EXPOSE 26000

# Install wget and unzip
RUN yum install -y wget unzip

# Decompress unrealircd into docker image
RUN wget http://dl.xonotic.org/xonotic-0.8.1.zip

# Unzip Xonotic archive
RUN unzip xonotic*

# Move files and delete archive
RUN mv Xonotic /opt/; rm xonotic-0.8.1.zip

# Remove uneeded files
RUN cd /opt/Xonotic; \
	rm -rf Docs \
		Makefile \
		Xonotic.app \
		bin32 \
		source \
		*.exe \
		xonotic-osx-dedicated \
		xonotic-linux32* 

# Create a group and user to run unrealircd (running as root is dangerous and not advised)
RUN groupadd -r xonoticadmin && useradd -r -m -g xonoticadmin xonoticadmin

# Change the ownership of the Xonotic directory so xonoticadmin can compile and run the files therein
RUN chown -R xonoticadmin:xonoticadmin /opt/Xonotic

# Switch to the xonoticadmin user
USER xonoticadmin

# Copy Xonotic server configuration (Defaults will work, but please modify for things like rcon support)
COPY files/server.cfg /opt/Xonotic/data/server.cfg

# Run Xonotic server
CMD ["sh","/opt/Xonotic/xonotic-linux-dedicated.sh"]
