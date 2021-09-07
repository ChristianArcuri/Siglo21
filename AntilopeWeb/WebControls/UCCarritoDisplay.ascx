<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCCarritoDisplay.ascx.cs" Inherits="AntilopeWeb.WebControls.UCCarritoDisplay" %>



<div class="top-shoping-cart">	
   
    
	<div class="top-mycart">
		<a class="top-mycart-link" href="Cart.aspx">Mi Carrito                 
            <asp:Literal ID="LitCantYTotal" runat="server"></asp:Literal>
		</a>
		<div class="top-mycart-overlay">			
            <asp:Literal ID="LitDetalleCarro" runat="server"></asp:Literal>	
			<div class="total-calculate">
				<p><span>subtotal</span> $<asp:Label ID="LblPrecioSubTotalCarro" runat="server" Text="0" Font-Size="15px"></asp:Label>
                    <a class="topcart-check-btn" href="Cart.aspx">Comprar</a>
				</p>
			</div>
		</div>
	</div>
</div>


