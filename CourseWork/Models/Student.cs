using System;
using System.Collections.Generic;
using System.IO;

namespace CourseWork.Models;

public partial class Student
{
    public int Id { get; set; }

    public string Surname { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string Patronymic { get; set; } = null!;

    public string? DoB { get; set; }

    public string Gruppa { get; set; } = null!;

    public decimal Gpa { get; set; }

    public string Photo { get; set; } = null!;

    public virtual string? ImagePath
    {

        get
        {
            if (File.Exists(System.IO.Path.Combine(Environment.CurrentDirectory, $"images/{Photo}")))
            {
                return System.IO.Path.Combine(Environment.CurrentDirectory, $"images/{Photo}");
            }
            else
            {
                Photo = "picture.png";
                return null;
            }
        }

    }
}
