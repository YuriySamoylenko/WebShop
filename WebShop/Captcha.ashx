<%@ WebHandler Language="C#" Class="Captcha" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.IO;
using System.Web.SessionState;

public class Captcha : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
           // константы
           const int width = 75; // ширина изображения CAPTCHA
           const int height = 25; // высота изображения CAPTCHA
           Color backgroundColor = Color.DarkBlue; // цвет фона
           Brush foregroundBrush = Brushes.White; // brush для текста и линий
           const int fontSize = 16; // размер текста

           // текст для CAPTCHA передается через переменную сессии
           if (context.Session["Captcha"] == null) return;
           string captcha = context.Session["Captcha"].ToString();

           // создаем bitmap-объект изображение в качестве холста для рисования
           Bitmap bitmap = new Bitmap(width, height);

           // получаем Graphics – своего рода «контроллер» рисования,
           // мы его создаем на основе нашего bitmap
           Graphics graphics = Graphics.FromImage(bitmap);

           // следующие два свойства выставляем, чтобы границы текста
           // были плавные, это усложнит его машинное распознавание
           graphics.SmoothingMode = SmoothingMode.AntiAlias;
           graphics.TextRenderingHint =  TextRenderingHint.AntiAlias;
           graphics.Clear(backgroundColor); // заливаем фон

           // шрифт для текста
           Font font = new Font("Calibri", fontSize, FontStyle.Bold);

           // рисуем текст.
           graphics.DrawString(captcha, font, foregroundBrush, 0, 0);
           font.Dispose();

           // теперь можно было бы остановиться, но так текст легко
           // распознать с изображения, поэтому необходимо его как-то трансформировать;
           // я вытяну его вправо за середину и наложу сверху случайные линии мусора

           // вытягиваю текст путем перемещения части пикселов bitmap,
           // чем ближе пиксел к серединной линии – тем сильнее будет
           // смещение пиксела вправо
           for (int i = 0; i < width; i++)
           {
               for (int j = 0; j < height; j++)
               {
                   int offset = Math.Abs(height/2 - j);
                   if (i + offset < width)
                   {
                       Color pixel = bitmap.GetPixel(i + offset, j);
                       bitmap.SetPixel(i, j, pixel);
                   }
               
               }
           }

           //// теперь рисую линии мусора
           //var pen = new Pen(foregroundBrush); // карандаш

           //// случайные значения для координат
           //var rnd = new byte[linesCount*4];
           ////CaptchaControl.Rand.GetBytes(rnd);

           //// рисую линии
           //for (int i = 0; i < linesCount; i++)
           //    graphics.DrawLine(pen, rnd[4 * i] % width, rnd[4 * i + 1] % height,
           //                       rnd[4 * i + 2] % width, rnd[4 * i + 3] % height);
           
           //pen.Dispose();

           // теперь изображение готово, мне нужно преобразовать его
           // в поток байт, чтобы вернуть браузеру
           MemoryStream stream = new MemoryStream();
           bitmap.Save(stream,System.Drawing.Imaging.ImageFormat.Png); // сохраняю в бинарный поток
                                                 // в памяти в формате PNG

           graphics.Dispose();

           // выставляю заголовок ответа Content-Type,
           // чтобы браузер понял формат изображения
           context.Response.ContentType = "image/png";

           // выгружаю в ответ двоичный поток изображения
           context.Response.BinaryWrite(stream.GetBuffer());
           context.Response.Flush();

           stream.Close();

           bitmap.Dispose();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}