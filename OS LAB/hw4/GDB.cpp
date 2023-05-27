 #include<iostream>
     
     using namespace std;
     
     long factorial(int n);
     
     int main()
     {
         int n;
         cin>>n;
         long val=factorial(n);
         cout<<val;
         
         return 0;
     }
     
     long factorial(int n)
     {
         long result=1;
         while(n--)
         {
             result*=n;
         }
         return result;
     }