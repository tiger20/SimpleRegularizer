function new_y = proxFConj(y)
absy = abs(y);
if absy > 1
    new_y = y/absy;
else
    new_y = y;
end