X = [1 1 1 1 -1 -1 1 -1 -1 1 -1 1 -1 -1 1 -1 1 -1 -1 1 -1 1 1 1 -1;
1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 1 -1 1 1 1 -1 -1;
-1 1 1 1 1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 1 1 1;
1 -1 -1 -1 1 1 1 -1 1 1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 1]';

[m,n] = size(X);
W = zeros(m,m);
for i = 1:n
    W = W + X(:,i)*X(:,i)';
end

W(logical(eye(size(W)))) = 0;
W = W/n;

no_bits_can_damage = 0;
no_iteration = 0;

for i = 1:100
    pattern = 2; % 1 --> D, 2 --> J, 3 --> C & 4 --> M
    x_original = X(:,pattern);
    x = X(:,pattern);
    x(3)=-1*x(3);
    no_damage_bit = randi([1, 25]);

    for m = 1:no_damage_bit
        ptr = randi([1, 25]);
        x(ptr) = -1 * x(ptr);
        disp(ptr);
    end
   
    y = x;
    erry = 10;
    count=0;
    while erry > 1 & count<10
        yp = sign(W*y);    
        count = count+1;
        erry = norm(yp-y);
        y = yp;
    end

    if(x_original==y)
        no_iteration = no_iteration + 1;
        no_bits_can_damage = no_bits_can_damage + no_damage_bit;
    end
end

disp(no_bits_can_damage);
disp(no_iteration);
ans_var = no_bits_can_damage/no_iteration;
disp("Answer:");
disp(ans_var);