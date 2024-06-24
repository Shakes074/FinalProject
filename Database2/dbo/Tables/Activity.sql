CREATE TABLE [dbo].[Activity] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NULL,
    [Description] VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

