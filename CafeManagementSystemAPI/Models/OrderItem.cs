using CafeManagementSystemAPI.Models;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

public class OrderItem
{
    [Key]
    public int OrderItemID { get; set; }

    [Required]
    public int OrderID { get; set; }

    [ForeignKey(nameof(OrderID))]
    [JsonIgnore]
    public Order Order { get; set; }

    [Required]
    public int MenuItemID { get; set; }

    [ForeignKey(nameof(MenuItemID))]
    [JsonIgnore]
    public MenuItem MenuItem { get; set; }

    [Required]
    public int Quantity { get; set; }

    [Required]
    [Column(TypeName = "decimal(18,2)")]
    public decimal Price { get; set; }
}
