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

namespace Lab_10
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
            string str1="select snum from student";
            SqlDataAdapter myAdapter = new SqlDataAdapter(str1, myconn);
            DataSet myDataSet = new DataSet();
            myAdapter.Fill(myDataSet, "snum");
            comboBox1.DataSource = myDataSet.Tables["snum"];
            comboBox1.DisplayMember = "snum";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string mySnum=comboBox1.Text;
            string str2="select sname,count(secnum),avg(score) from student,sc "
                +"where student.snum=sc.snum and sc.snum='"+mySnum+"'"
                +" group by sname";
            SqlCommand myCmd=new SqlCommand(str2,myconn);
            myconn.Open();
            {
                SqlDataReader myReader;
                myReader=myCmd.ExecuteReader();
                if (myReader.Read())
                {
                    textBox1.Text = myReader.GetValue(0).ToString();
                    textBox2.Text = myReader.GetValue(1).ToString();
                    textBox3.Text = myReader.GetValue(2).ToString();
                }
            }
            myconn.Close();
        }
    }
}
