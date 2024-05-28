
using Interface;
using DAL;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Injections
builder.Services.AddSingleton<IRoles, RoleDAL>();
builder.Services.AddSingleton<IStatus, StatusDAL>();
builder.Services.AddSingleton<IActivity, ActivityDAL>();
builder.Services.AddSingleton<IEmployee, EmployeeDAL>();
builder.Services.AddSingleton<IBranch, BranchDAL>();
builder.Services.AddSingleton<IMember, MembersDAL>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
