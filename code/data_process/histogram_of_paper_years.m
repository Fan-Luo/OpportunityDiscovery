%load data
data =csvread('/Users/fan/Documents/RA/115k/up-to-date-results/pmc_year.csv', 1, 0);

%pmids = data (:,1);
years = data (:,2);
%sorted_years = sort(years);

% subplot(3,1,1);
% edges1 = 1897:2016;
% histogram(years,edges1);
% % Create ylabel
% ylabel({'number of papers'},'FontSize',15);
% count1 = histcounts(years,edges1);


% subplot(3,1,2)
edges2 = [1999 2000:1:2015 2016];
histogram(years,edges2);
% Create ylabel
ylabel({'Number of papers'},'FontSize',15);
xlabel({'Year'},'FontSize',15);

% subplot(3,1,3)
% edges3 = 2000:2:2016;
% histogram(years,edges3);
% % Create ylabel
% ylabel({'number of papers(log)'},'FontSize',15);
% set(gca,'yScale','log')
