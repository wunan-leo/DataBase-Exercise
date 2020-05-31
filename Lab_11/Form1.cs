using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Lab_11
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            SqlConnection myconn = new SqlConnection("Initial Catalog=university;Data Source = (local);Integrated Security = True;");
            SqlCommand myCmd=new SqlCommand("ProcA",myconn);
            myCmd.CommandType=CommandType.StoredProcedure;

            myconn.Open();
            {
                SqlDataReader dr = myCmd.ExecuteReader();
                BindingSource bs = new BindingSource();
                bs.DataSource = dr;
                this.dataGridView1.DataSource = bs;
            }
            myconn.Close();

        }
    }
}
