CREATE TABLE [dbo].[Branches] (
    [ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (100) NOT NULL,
    [Province] VARCHAR (50)  NOT NULL,
    [Country]  VARCHAR (50)  NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

