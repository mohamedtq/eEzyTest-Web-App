<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeScreen.aspx.cs" MasterPageFile="~/eEzyTest.Master" Inherits="MdTStudios.eEzyTest.HomeScreen" %>


<asp:Content ContentPlaceHolderID="PageContent" runat="server">
    <asp:Label runat="server" ID="lblShow" />
    <asp:LinkButton runat="server" OnClick="Unnamed_Click" Text="Log out" />
    <asp:GridView ID="gvUsersTable" runat="server"></asp:GridView>
</asp:Content>
