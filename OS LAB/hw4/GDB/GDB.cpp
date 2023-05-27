 #include<iostream>
     
     using namespace std;
     
     long factorial(int n);
     
     int main()
     {
         int n;
         cin>>n;
         long val=factorial(n);
         cout<<val;
         cin.get();
         return 0;
     }
     
     long factorial(int n)
     {
       long result(1);
         while(n>0) //ejaze nabayad dahim k n=0 shavad
         {
             result*=n;
		n--;
         }
         return result;
     }
