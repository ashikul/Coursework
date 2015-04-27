%{
@Ashikul Alam
02/16/2015
ESE 346 Computer Communications 
Project 1 :
Network of VLSI Switching Elements

%}

%probability values
p_intial = 0.02;
p_final = 1.00;
p_increment = 0.02;
%number of trials
trials = 1000;
%A, B , C output
A = zeros(50, trials);
B = zeros(50, trials);
C = zeros(50, trials);

for p = 1:50;
    for n = 1:trials;
        %generate 4 packets with 0 or 1
        %with probability p*0.02
        if rand < p*0.02
            packetA1=1;
        else
            packetA1=0;
        end
        if rand < p*0.02
            packetA2=1;
        else
            packetA2=0;
        end
        if rand < p*0.02
            packetB1=1;
        else
            packetB1=0;
        end
        if rand < p*0.02
            packetB2=1;
        else
            packetB2=0;
        end
        
        %use OR function to mimic packet dropping
        A(p,n) = packetA1 | packetA2;
        B(p,n) = packetB1 | packetB2;
        C(p,n) = A(p,n) | B(p,n);
 
    end
end

%calculate throughput for A and C
throughputA = zeros(50,1);
throughputC = zeros(50,1);

for p = 1:50;
    for n = 1:trials;
        throughputA(p) = throughputA(p) + A(p,n);
        throughputC(p) = throughputC(p) + C(p,n);
    end
    throughputA(p) = throughputA(p)/1000;
    throughputC(p) = throughputC(p)/1000;
end

%plot throughput of A and C vs p
plot(throughputA, 'b');
hold on
plot(throughputC, 'r');
hold off






