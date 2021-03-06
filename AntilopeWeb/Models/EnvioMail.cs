using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;  //Para mail
using System.Net.Mail; //Para mail
//using Excel = Microsoft.Office.Interop.Excel;
using System.Collections;
using System.IO;
using System.Net.Mime;
using AntilopeWeb.Models;



/// <summary>
/// Summary description for EnvioMail
/// </summary>
public class EnvioMail
{

    bool IsValidEmail(string email) //Chequea formato de mails
    {
        try
        {
            
            //var addr = new System.Net.Mail.MailAddress(email);
            System.Net.Mail.MailAddress addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }


    public bool EnvioMailAltaUsuario(string Titulo,string Mensaje, string Asunto, string Destinatarios, string DestCC, string Href, bool MailActivado,string Accion)
    {

        try
        {
            if (MailActivado == true)
            {
                string[] lectura = new string[1000];  //Vector que lee el renglon.
                string[] lecturaCC = new string[1000];  //Vector que lee el renglon.
                string DestLog = "christianarcuri@hotmail.com";
                MailMessage Msg = new MailMessage();
                FuncionesGrales Func = new FuncionesGrales();
                StreamReader reader;                

                if (Destinatarios != null && Destinatarios != "" && Destinatarios != "&nbsp;")
                {
                    lectura = Destinatarios.Split(';');   //Separamos cada prop. del texto, separado por punto y coma.                
                    foreach (string dire in lectura)
                    {
                        string direccion = Func.RemoveSpecialCharacters(dire); //Quita los caracteres especiales.
                        if (IsValidEmail(direccion)) //Valida el formato de mails
                        {
                            Msg.To.Add(direccion);
                        }
                        else
                        {
                            Msg.To.Add(DestLog);
                            Asunto = Asunto + " Error destinatarios erroneos ( " + direccion + " )";
                        }
                    }
                    if (DestCC != null && DestCC != "")
                    {
                        lecturaCC = DestCC.Split(';');   //Separamos cada prop. del texto, separado por punto y coma.
                        foreach (string direCC in lecturaCC)
                        {
                            string direccion = Func.RemoveSpecialCharacters(direCC); //Quita los caracteres especiales.
                            if (IsValidEmail(direccion))
                            {
                                Msg.CC.Add(direccion);
                            }
                        }
                    }
                }
                else
                {
                    Msg.To.Add(DestLog);
                    Asunto = Asunto + " Error destinatarios vacíos";
                }
                reader = new StreamReader(HttpContext.Current.Server.MapPath("EmailAltaUsuario.html"));                

                string readFile = reader.ReadToEnd();
                string StrContent = "";
                StrContent = readFile;                
                StrContent = StrContent.Replace("[MENSAJE]", Mensaje);
                StrContent = StrContent.Replace("[SUBJECT]", Asunto);
                StrContent = StrContent.Replace("[email]", Destinatarios.Split(';')[0]);
                StrContent = StrContent.Replace("[ACCION]", Accion);
                StrContent = StrContent.Replace("[CLIENTS.WEBSITE]", Href);
                

                Msg.Body = StrContent.ToString();
                Msg.IsBodyHtml = true;
                Msg.From = new MailAddress("infocampus@rycmass.net");
                Msg.Subject = Asunto;
                Msg.Priority = System.Net.Mail.MailPriority.Normal;
                SmtpClient clienteSmtp = new SmtpClient();
                Msg.IsBodyHtml = true; // solo para hotmail   
                Msg.BodyEncoding = System.Text.Encoding.UTF8;
                clienteSmtp.Port = 25;
                clienteSmtp.Host = "smtp.rycmass.net";
                clienteSmtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                string usuario = "infocampus@rycmass.net";
                string password = "campus422";
                clienteSmtp.Credentials = new NetworkCredential(usuario, password);


                string html = @"<html><body><img src=""cid:Logo""></body></html>";                
                AlternateView altView = AlternateView.CreateAlternateViewFromString(StrContent, null, MediaTypeNames.Text.Html);
                LinkedResource Logo = new LinkedResource(HttpContext.Current.Server.MapPath("img/mail/LogoAntilope1.png"), MediaTypeNames.Image.Jpeg);
                LinkedResource X62 = new LinkedResource(HttpContext.Current.Server.MapPath("img/mail/6@2x.png"), MediaTypeNames.Image.Jpeg);

                Logo.ContentId = "Logo";
                altView.LinkedResources.Add(Logo);
                X62.ContentId = "X62";
                altView.LinkedResources.Add(X62);

                Msg.AlternateViews.Add(altView);
                clienteSmtp.Send(Msg);
            }
            else
            {
                return true;
            }


            return true;
        }
        catch (Exception ex)
        {            
            return false;
        }

    }
    
    
}
