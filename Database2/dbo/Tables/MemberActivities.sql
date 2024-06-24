CREATE TABLE [dbo].[MemberActivities] (
    [ID]         INT IDENTITY (1, 1) NOT NULL,
    [MemberID]   INT NOT NULL,
    [ActivityID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([ActivityID]) REFERENCES [dbo].[Activity] ([ID]),
    FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Members] ([ID])
);

