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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        static SqlConnection myconn = new SqlConnection("Initial Catalog=university;Data Source = (local);Integrated Security = True;");
        private void Form1_Load(object sender, EventArgs e)
        { 
            string str1="select snum from student";
            SqlDataAdapter myAdapter = new SqlDataAdapter(str1, myconn);
            DataSet myDataSet=new DataSet();
            myAdapter.Fill(myDataSet,"snum");
            comboBox1.DataSource=myDataSet.Tables["snum"];
            comboBox1.DisplayMember = "snum";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str2 = "select secnum from sections except "
               + "select secnum from sc where snum= '" + comboBox1.Text + "' ";
            SqlDataAdapter myAdapter2 = new SqlDataAdapter(str2, myconn);
            DataSet myDataSet=new DataSet();
            myAdapter2.Fill(myDataSet, "secnum");
            comboBox2.DataSource = myDataSet.Tables["secnum"];
            comboBox2.DisplayMember = "secnum";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string myScore=textBox1.Text;
            string mySnum=comboBox1.Text;
            string mySecnum=comboBox2.Text;
            string cmd="insert into sc values('"+mySnum+"','"+mySecnum+"',"+int.Parse(myScore)+")";
            SqlCommand myCmd=new SqlCommand(cmd,myconn);
            myconn.Open();
            {
                try
                {
                    myCmd.ExecuteNonQuery();
                    
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
                MessageBox.Show("学生成绩添加完成！");
            }
            myconn.Close();
        }
    }
}
