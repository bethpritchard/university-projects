
function x = heapsort(x)%main function
    n = numel(x); %length of the data input 
    x = buildheap(x,n);  %calls buildheap function
    for i = numel(x):-1:2 %Extracts elements one by one
        x([i 1]) = x([1 i]);
        n = n - 1;
        x = heapify(x,n,1);
    end
    
end

function x = heapify(x,n,i)
%parent node index is i
    L = 2 * i; %left child index is 2*i 
    R = 2 * i + 1; %right child index is 2*1+1 
    
     %determine if left child exists and is greater than the parent
    if L <= n && x(L) > x(i)
        max = L;
    else
        max = i;
        
     %determine if right child exists and is greater than the parent   
    end
    if R <= n && x(R) > x(max)
        max = R;
    end
    
    %change parent node if needed 
    if max ~= i
        x([max i]) = x([i max]);
        
        %heapify the parent node
        x = heapify(x,n,max);
    end
end

function x = buildheap(x,n) 
    for i = floor(n/2):-1:1 %builds a max heap by rearranging array
        x = heapify(x,n,i); %makes parent node greater than children
    end
end
