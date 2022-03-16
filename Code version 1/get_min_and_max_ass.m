% ---------------------------------------------------------
% Description: this function returns the minimum and maximum on the asset
% grid in each year. The minimum is the natural borrowing constraint. The
% maximum is how much one would have by saving everything.

function [ BC, maxA ] = get_min_and_max_ass(initial_assets)
