CREATE TABLE [dbo].[Status] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (200) NOT NULL,
    [Criteria]    VARCHAR (200) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

