# marketSimulator
Simulate trading in financial market
This code is to create alerts and discard stray ticks from a stock feed. 
The code can be customized to add multiple strategies. The feed is monitored, and 
depending upon the swings, different queues are written into. Smaller scripts 
can be used to monitor those queses, and they can be tasked with specific functions. 
This way, we can scale up the system to perform multiple functions easily. 
