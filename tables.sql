

CREATE TABLE CUSTOMER( customerId INT NOT NULL AUTO_INCREMENT, 
                       customerName VARCHAR(62) NOT NULL,
                       customerAddress VARCHAR(128),
                       customerType VARCHAR(10) NOT NULL,
                       PRIMARY KEY(customerId)
                    );

CREATE TABLE TICKER_GROUP(tickerGroupId INT NOT NULL,
                          tickerGroupName VARCHAR(32),
                          PRIMARY KEY(tickerGroupId)
                         );

CREATE TABLE TICKER (tickerSymbol VARCHAR(32) NOT NULL,
                     tickerDescription VARCHAR(128) NOT NULL,
                     tickerGroupId INT NOT NULL,
                     CONSTRAINT FOREIGN KEY(tickerGroupId) REFERENCES TICKER_GROUP(tickerGroupId),
                     PRIMARY KEY(tickerSymbol)
                    );


CREATE TABLE CUSTOMER_PORTFOLIO(customerId INT NOT NULL,
                                tickerSymbol VARCHAR(32) NOT NULL,
                                lowerTrigger FLOAT,
                                higherTrigger FLOAT,
                                orderStatus VARCHAR(8) NOT NULL,
				CONSTRAINT FOREIGN KEY(customerId) REFERENCES CUSTOMER(customerId),
				CONSTRAINT FOREIGN KEY(tickerSymbol) REFERENCES TICKER(tickerSymbol)
                               );
                                

CREATE TABLE ORDER_BOOK ( customerId VARCHAR(32) NOT NULL,
                          tickerSymbol VARCHAR(32) NOT NULL,
                          orderType VARCHAR(6) NOT NULL,
                          numberOfUnits INT NOT NULL,
                          action VARCHAR(4) NOT NULL,
                          unitPrice FLOAT NOT NULL,
                          timeOfAction TIMESTAMP NOT NULL
                        ); 

