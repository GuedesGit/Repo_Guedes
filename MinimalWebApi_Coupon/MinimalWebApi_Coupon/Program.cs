using Microsoft.AspNetCore.Mvc;
using MinimalWebApi_Coupon.Data;
using MinimalWebApi_Coupon.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//Main Code for Web Api
{
    app.MapGet("/api/coupon", () => Results.Ok(CouponStore.couponList)).Produces<IEnumerable<Coupon>>(200);

    app.MapGet("/api/coupon/{id:int}", (int id) =>
    {
        var findCoupon = CouponStore.couponList.FirstOrDefault(x => x.Id == id);

        return findCoupon is null ? Results.NotFound() : Results.Ok(findCoupon);
    }).WithName("GetCoupons");

    app.MapPost("/api/coupon", ([FromBody] Coupon coupon) =>
    {
        if (coupon.Id != 0 && string.IsNullOrEmpty(coupon.Name))
            return Results.BadRequest("Invalid Id or Coupon Name!");

        if (CouponStore.couponList.FirstOrDefault(u => u.Name.Equals(coupon.Name, StringComparison.CurrentCultureIgnoreCase)) != null)
            return Results.BadRequest("Coupon Name already exists!");

        coupon.Id = CouponStore.couponList.OrderByDescending(u => u.Id).FirstOrDefault().Id + 1;
        CouponStore.couponList.Add(coupon);

        return Results.CreatedAtRoute("GetCoupon", new { id = coupon.Id }, coupon);
        //return Results.Created($"/api/coupon/{coupon.Id}",coupon);

    }).WithName("CreateCoupon").Produces<Coupon>(201).Produces(400);

    app.MapPut("/api/coupon", () =>
    {
    });

    app.MapDelete("/api/coupon/{id}", (int id) =>
    {
        bool res = CouponStore.couponList.RemoveAll(x => x.Id == id) > 0;

        return res ? Results.Ok() : Results.BadRequest();
    });

}

app.UseHttpsRedirection();
app.Run();

internal record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
