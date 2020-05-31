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
    public partial class Form3 : Form
    {
        public Form3()
        {
            InitializeComponent();
        }
        static SqlConnection myconn = new SqlConnection("Initial Catalog=university;Data Source = (local);Integrated Security = True;");
        private void Form3_Load(object sender, EventArgs e)
        {
            string str1="select snum from student";
            SqlDataAdapter myAdapter=new SqlDataAdapter(str1,myconn);
            DataSet myDataSet=new DataSet();
            myAdapter.Fill(myDataSet,"snum");
            comboBox1.DataSource=myDataSet.Tables["snum"];
            comboBox1.DisplayMember="snum";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlCommand myCmd = new SqlCommand("ProcC", myconn);
            myCmd.CommandType = CommandType.StoredProcedure;
            SqlParameter snum = new SqlParameter("@_snum", SqlDbType.Char, 4);
            myCmd.Parameters.Add(snum);
            snum.Value = comboBox1.Text.Trim();
            SqlParameter avg = new SqlParameter("@_avg", SqlDbType.Int);
            myCmd.Parameters.Add(avg);
            avg.Direction = ParameterDirection.Output;
            SqlParameter all_cource = new SqlParameter("@_all_cource", SqlDbType.Int);
            myCmd.Parameters.Add(all_cource);
            all_cource.Direction = ParameterDirection.Output;
            SqlParameter fail = new SqlParameter("@_fail", SqlDbType.Int);
            myCmd.Parameters.Add(fail);
            fail.Direction = ParameterDirection.Output;
            myconn.Open();
            {
                myCmd.ExecuteNonQuery();
                textBox1.Text=avg.Value.ToString();
                textBox2.Text=all_cource.Value.ToString();
                textBox3.Text=fail.Value.ToString();
            }
            myconn.Close();
        }
    }
}
