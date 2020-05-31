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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        static SqlConnection myconn = new SqlConnection("Initial Catalog=university;Data Source = (local);Integrated Security = True;");
        private void Form2_Load(object sender, EventArgs e)
        {
            string str1="select distinct year(birthday) as 'year' from student";
            SqlDataAdapter myAdapter=new SqlDataAdapter(str1,myconn);
            DataSet myDataSet=new DataSet();
            myAdapter.Fill(myDataSet,"year");
            comboBox1.DataSource=myDataSet.Tables["year"];
            comboBox1.DisplayMember="year";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

            SqlCommand myCmd = new SqlCommand("ProcB", myconn);
            myCmd.CommandType=CommandType.StoredProcedure;
            SqlParameter birthday=new SqlParameter("@_year",SqlDbType.Int);
            myCmd.Parameters.Add(birthday);
            if (comboBox1.Text != "System.Data.DataRowView")
            {
                birthday.Value = int.Parse(comboBox1.Text);
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
}
