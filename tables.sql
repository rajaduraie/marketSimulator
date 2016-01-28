

CREATE TABLE CUSTOMER( customerId INT NOT NULL AUTO INCREMENT, 
                       customerName VARCHAR(62) NOT NULL,
                       customerAddress VARCHAR(128),
                       customerType VARCHAR(10) CHECK('RETAIL', 'COMMERCIAL'),
                       PRIMARY KEY(customerId)
                    );

CREATE TABLE TICKER_GROUP(tickerGroupId INT NOT NULL,
                          tickerGroupName VARCHAR(32)
                         );

CREATE TABLE TICKER (tickerName VARCHAR(32) NOT NULL,
                     tickerDescription VARCHAR(128) NOT NULL,
                     tickerGroupId INT NOT NULL,
                     CONSTRAINT FOREIGN KEY(tickerGroupId) REFERENCES TICKER_GROUP(tickerGroupId)
                    );


CREATE TABLE CUSTOMER_PORTFOLIO(customerId INT NOT NULL,
                                tickerSymbol VARCHAR(32) NOT NULL,
                                lowerTrigger FLOAT,
                                higherTrigger FLOAT,
                                orderStatus VARCHAR(8) CHECK('NEW', 'HOLD', 'PARTIAL','COMPLETE'),
				CONSTRAINT FOREIGN KEY(customerId) REFERENCES CUSTOMER(customerId),
				CONSTRAINT FOREIGN KEY(tickerSymbol) REFERENCES TICKER(tickerSymbol)
                               );
                                

CREATE TABLE ORDER_BOOK ( customerId VARCHAR(32) NOT NULL,
                          tickerSymbol VARCHAR(32) NOT NULL,
                          orderType VARCHAR(6) NOT NULL CHECK('LIMIT', 'MARKET'),
                          numberOfUnits INT NOT NULL,
                          action VARCHAR(4) CHECK CONSTRAINT('BUY','SELL'),
                          unitPrice FLOAT NOT NULL,
                          timeOfAction TIMESTAMP NOT NULL
                        ); 

