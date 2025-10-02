using System;

class Program
{
    static void Main(string[] args)
    {
        string password = "honan123";
        string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
        Console.WriteLine($"Password: {password}");
        Console.WriteLine($"BCrypt Hash: {hashedPassword}");
        
        // 验证哈希是否正确
        bool isValid = BCrypt.Net.BCrypt.Verify(password, hashedPassword);
        Console.WriteLine($"Verification: {isValid}");
    }
}