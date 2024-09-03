using CafeManagementSystemAPI.Models;
using Microsoft.EntityFrameworkCore;

public class CafeManagementContext : DbContext
{
    public CafeManagementContext(DbContextOptions<CafeManagementContext> options)
        : base(options)
    {
    }

    public DbSet<Inventory> Inventory { get; set; }
    public DbSet<MenuItem> MenuItem { get; set; }
    public DbSet<User> User { get; set; }
    public DbSet<Order> Order { get; set; }
    public DbSet<OrderItem> OrderItem { get; set; }
    public DbSet<Transaction> Transaction { get; set; }

    // Optionally override OnModelCreating to configure the model
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Order>()
            .HasMany(o => o.OrderItems)
            .WithOne(oi => oi.Order)
            .HasForeignKey(oi => oi.OrderID);

        modelBuilder.Entity<OrderItem>()
            .HasOne(oi => oi.MenuItem)
            .WithMany()
            .HasForeignKey(oi => oi.MenuItemID);
    }

}
