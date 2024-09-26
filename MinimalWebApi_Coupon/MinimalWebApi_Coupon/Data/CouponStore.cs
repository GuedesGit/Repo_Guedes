using MinimalWebApi_Coupon.Models;
using System.Xml.Linq;

namespace MinimalWebApi_Coupon.Data
{
    public class CouponStore
    {
        public static List<Coupon> couponList = new List<Coupon>()
        {
            new Coupon() {Id=1,Name="Tshirt Adidas",Percent=10,IsActive=true },
            new Coupon() {Id=2,Name="Tshirt Nike",Percent=10,IsActive=false} };
    }
        
}
