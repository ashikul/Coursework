%{
@Ashikul Alam
03/29/2015
ESE 346 Computer Communications
Project 2 :
Performance Evaluation of a Space Division Packet Switching

%}

trials = 1000;
input = zeros(5,1);
output = zeros(5,1);
success = zeros(100, trials, 3);
dropped = zeros(100, trials, 3);

for N = 3:5;
    for p = 1:100;
        for nslots = 1:trials;
            
            input = zeros(5,1);
            output = zeros(5,1);
            
            for packet = 1:N;
                if rand < p*0.01
                    input(packet)=1;
                    o = randi([1 N]);
                    if output(o) == 0
                        output(o) = 1;
                    else
                        dropped(p, nslots, N-2) = dropped(p, nslots, N-2) +1;
                    end
                else
                    input(packet)=0;
                end
            end
            
            for packet = 1:N;
                if output(packet) == 1
                    success(p, nslots, N-2) = success(p, nslots, N-2) +1;
                end
            end
            
        end
    end
end

%calculate throughputs for successful and dropped packets and normalize
success3 = zeros(100,1);
success4 = zeros(100,1);
success5 = zeros(100,1);

dropped3 = zeros(100,1);
dropped4 = zeros(100,1);
dropped5 = zeros(100,1);

for p = 1:100;
    for nslots = 1:trials;
        success3(p) = success3(p) + success(p,nslots, 1);
        success4(p) = success4(p) + success(p,nslots, 2);
        success5(p) = success5(p) + success(p,nslots, 3);
        dropped3(p) = dropped3(p) + dropped(p,nslots, 1);
        dropped4(p) = dropped4(p) + dropped(p,nslots, 2);
        dropped5(p) = dropped5(p) + dropped(p,nslots, 3);
    end
    success3(p) = success3(p)/(3*trials);
    success4(p) = success4(p)/(4*trials);
    success5(p) = success5(p)/(5*trials);
    dropped3(p) = dropped3(p)/(3*trials);
    dropped4(p) = dropped4(p)/(4*trials);
    dropped5(p) = dropped5(p)/(5*trials);
end

%theoretical throughout for success
theoreticalsuccess3 = zeros(100,1);
theoreticalsuccess4 = zeros(100,1);
theoreticalsuccess5 = zeros(100,1);
for p = 1:100;
    P = p*0.01;
    theoreticalsuccess3(p) = (1-(1-P/3)^3);
    theoreticalsuccess4(p) = (1-(1-P/4)^4);
    theoreticalsuccess5(p) = (1-(1-P/5)^5);
end

%plot of throughputs, simulated vs theoretical
hold on
plot(success3, 'b');
plot(success4, 'r');
plot(success5, 'g');
plot(theoreticalsuccess3, 'm');
plot(theoreticalsuccess4, 'k');
plot(theoreticalsuccess5, 'y');
hold off

%plot of dropped packets, simulated only
hold on
plot(dropped3, 'b');
plot(dropped4, 'r');
plot(dropped5, 'g');
hold off






