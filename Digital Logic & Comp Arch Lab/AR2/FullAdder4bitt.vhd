library ieee;
use ieee.std_logic_1164.all;
entity fa_4bit is
  port(a,b:in std_logic_vector(3 downto 0);
    cin:in std_logic;
    sum:out std_logic_vector(3 downto 0);
    carry:out std_logic);
  end fa_4bit;
  architecture struct1 of fa_4bit is
    --component declaration
component fa
  port(x,y,z:in std_logic;
    s,c:out std_logic);
  end component;
   signal carry1,carry2,carry3:std_logic;
        begin
          --component instanse
          u0:fa port map(x=>a(0),y=>b(0),z=>cin,s=>sum(0),c=>carry1);
            u1:fa port map(x=>a(1),y=>b(1),z=>carry1,s=>sum(1),c=>carry2);
              u2:fa port map(x=>a(2),y=>b(2),z=>carry2,s=>sum(2),c=>carry3);
              u3:fa port map(x=>a(3),y=>b(3),z=>carry3,s=>sum(3),c=>carry);
                carry<=carry1 or carry2 or carry3;
            end struct1;