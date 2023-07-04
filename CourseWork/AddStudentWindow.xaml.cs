using CourseWork.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace CourseWork
{
    public partial class AddStudentWindow : Window
    {

        Student? currentStudents;

        string? oldImage;
        string? newImage;
        string? newImagePath;

        public AddStudentWindow(Student student)
        {
            InitializeComponent();
            this.Title = "Добавление студента";

            using (CourseWorkContext db = new CourseWorkContext())
            { }
            if (student != null)
            {
                currentStudents = student;
                this.Title = "Редактирование студента";
                DataContext = currentStudents;
            }
        }

        private void saveProductButtonClick(object sender, RoutedEventArgs e)
        {
            // валидация 

            using (CourseWorkContext db = new CourseWorkContext())
            {


                if (currentStudents == null)
                {

                    try
                    {
                        Student student = new Student()
                        {
                            Surname = surnameBox.Text,
                            Name = nameBox.Text,
                            Patronymic = patronymicBox.Text,
                            DoB = dobBox.Text,
                            Photo = imageBox.Text, // "picture.png",
                            Gruppa = gruppaBox.Text,
                            Gpa = Convert.ToDecimal(gpaBox.Text)
                        };

                        db.Students.Add(student);

                        // если не было выбрано фото

                        if (String.IsNullOrEmpty(newImage))
                        {
                            student.Photo = "picture.png";
                            BitmapImage image = new BitmapImage(new Uri(student.ImagePath));
                            image.CacheOption = BitmapCacheOption.OnLoad;
                            imageBoxPath.Source = image;
                        }
                        else // если выбрано фото
                        {
                            string newRelativePath = $"{System.DateTime.Now.ToString("HHmmss")}_{newImage}";
                            student.Photo = newRelativePath;

                            File.Copy(newImagePath, System.IO.Path.Combine(Environment.CurrentDirectory, $"images/{newRelativePath}"));

                            BitmapImage image = new BitmapImage(new Uri(student.ImagePath));
                            image.CacheOption = BitmapCacheOption.OnLoad;
                            imageBoxPath.Source = image;
                        }

                        db.SaveChanges();

                        MessageBox.Show("Студент успешно добавлен!");


                        MainWindow mainWindow = Application.Current.Windows.OfType<MainWindow>().FirstOrDefault();
                        (mainWindow.FindName("studentslistView") as ListView).ItemsSource = db.Students.ToList();
                        (mainWindow.FindName("countStudents") as TextBlock).Text = $"Количество: {db.Students.Count()}";


                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }

                }
                else
                {

                    // если выбрано новое фото
                    if (newImage != null)
                    {
                        string newRelativePath = $"{System.DateTime.Now.ToString("HHmmss")}_{newImage}";
                        currentStudents.Photo = newRelativePath;
                        MessageBox.Show($"Новое фото: {currentStudents.Photo} присвоено!");
                        File.Copy(newImagePath, System.IO.Path.Combine(Environment.CurrentDirectory, $"images/{currentStudents.Photo}"));
                        newImage = null;
                    }


                    // если есть старое фото, то пытаемся его удалить

                    if (!string.IsNullOrEmpty(oldImage))
                    {
                        try
                        {
                            File.Delete(oldImage);
                            MessageBox.Show($"Старое фото: {oldImage} удалено!");
                            oldImage = null;
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message.ToString());
                        }
                    }


                    try
                    {
                        db.Students.Update(currentStudents);
                        db.SaveChanges();
                        MessageBox.Show("Студент успешно обновлен!");

                        MainWindow mainWindow = Application.Current.Windows.OfType<MainWindow>().FirstOrDefault();
                        (mainWindow.FindName("studentslistView") as ListView).ItemsSource = db.Students.ToList();
                        (mainWindow.FindName("countStudents") as TextBlock).Text = $"Количество: {db.Students.Count()}";
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }

                }
            }


        }

        private void AddImageToStudent(object sender, RoutedEventArgs e)
        {

            Stream myStream;

            if (currentStudents != null)
            {
                oldImage = System.IO.Path.Combine(Environment.CurrentDirectory, $"images/{currentStudents.Photo}");
            }
            else
            {
                oldImage = null;
            }

            // проверяем, есть ли изображение у товара и запоминаем путь к изображению сейчас

            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();

            if (dlg.ShowDialog() == true)
            {
                if ((myStream = dlg.OpenFile()) != null)
                {
                    dlg.DefaultExt = ".png";
                    dlg.Filter = "JPEG Files (*.jpeg)|*.jpeg|PNG Files (*.png)|*.png|JPG Files (*.jpg)|*.jpg|GIF Files (*.gif)|*.gif";
                    dlg.Title = "Open Image";
                    dlg.InitialDirectory = "./";

                    // Предпросмотр изображения
                    BitmapImage image = new BitmapImage();
                    image.BeginInit();
                    image.CacheOption = BitmapCacheOption.OnLoad;
                    image.CreateOptions = BitmapCreateOptions.IgnoreImageCache;
                    image.UriSource = new Uri(dlg.FileName);
                    imageBoxPath.Source = image;
                    image.EndInit();

                    try
                    {

                        newImage = dlg.SafeFileName;
                        newImagePath = dlg.FileName;

                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }
                }

                myStream.Dispose();
            }

        }

    }
}
