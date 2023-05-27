#include <stdio.h>
#include <string.h> //strlen
#include <sys/socket.h>
#include <arpa/inet.h> //inet_addr
#include <unistd.h> //write
int main(int argc , char *argv[])
{
int socket_desc , new_socket , c;
struct sockaddr_in server , client;
char *message;
//Socket
socket_desc = socket(AF_INET , SOCK_STREAM , 0);
if (socket_desc == -1)
{
printf("Could not create socket");
}
//sockaddr_in
server.sin_family = AF_INET;
server.sin_addr.s_addr = INADDR_ANY;
server.sin_port = htons( 8888 );
//
if( bind(socket_desc,(struct sockaddr *)&server ,
sizeof(server)) < 0)
{
puts("bind failed");
return 1;
}
puts("bind done");
//
listen(socket_desc , 3);
//accept requset
puts("Waiting for incoming connections...");
c = sizeof(struct sockaddr_in);
new_socket = accept(socket_desc, (struct sockaddr *)&client,
(socklen_t*)&c);
if (new_socket<0)
{
perror("accept failed");
return 1;
}
puts("Connection accepted");
//response
message = "Hello Client , I have received your connection. But I have to go now, bye\n";
write(new_socket , message , strlen(message));
return 0;
}
