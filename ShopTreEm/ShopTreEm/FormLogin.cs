using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ShopTreEm.Commons;
using ShopTreEm.Models;
using ShopTreEm.DAO;

namespace ShopTreEm
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }
        bool Login(string userName, string password)
        {
            return QuanTriVien_DAO.Instance.Login(userName, password);
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
			var tenDangNhap = txtUserName.Text;
			var matKhau = txtPass.Text;

			InputValidator inputValidator = new InputValidator();

			inputValidator
				.SetTitle("Tên đăng nhập")
				.SetInputString(tenDangNhap)
				.SanitizeInput()
				.Require()
				.MustBeValidString();

			inputValidator
				.SetTitle("Mật khẩu")
				.SetInputString(matKhau)
				.SanitizeInput()
				.Require();

			if (inputValidator.HasError)
			{
				MessageBox.Show(inputValidator.GetErrorMessage(), "Thông báo lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}

			if (!Login(tenDangNhap, matKhau))
			{
				MessageBox.Show("Sai tên tài khoản hoặc mật khẩu", "Thông tin không hợp lệ");
				return;
			}

			QuanTriVien_DTO loginAccount = QuanTriVien_DAO.Instance.GetAccountByUserName(tenDangNhap);

			frmShopTreEm f = new frmShopTreEm(loginAccount);
			this.Hide();
			f.ShowDialog();
			this.Show();
		}

        private void btnExit_Click(object sender, EventArgs e)
        {
			Application.Exit();
		}
		private void frmShopTreEm_FormClosing(object sender, FormClosingEventArgs e)
		{
			string msg = "Bạn có chắc chắn muốn thoát chương trình ?";
			var result = MessageBox.Show(msg, "Thoát", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
			if (result != DialogResult.Yes)
				e.Cancel = true;
		}
		private void cbShowPassword_CheckedChanged(object sender, EventArgs e)
		{
			txtPass.UseSystemPasswordChar = !cbShowPass.Checked;
		}
	}
}
