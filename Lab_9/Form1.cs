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

namespace Lab_9
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        static SqlConnection myConnection = new SqlConnection("Initial Catalog=university;Data Source=(local);Integrated Security=True;");
        private void Form1_Load(object sender, EventArgs e)
        {        

        }

        private void button1_Click(object sender, EventArgs e)
        {
            String mySql_1 = "select sname from student where snum='" + textBox1.Text + "'";
            SqlDataAdapter myAdapter_1 = new SqlDataAdapter(mySql_1, myConnection);
            DataSet myDataset = new DataSet();
            myAdapter_1.Fill(myDataset, "name");
            if(myDataset.Tables["name"].Rows.Count == 0)
            {
                MessageBox.Show("不存在该同学信息！");
            }
            else
            {
                label3.Text = myDataset.Tables["name"].Rows[0].ItemArray[0].ToString() + " 选修课程成绩";
                String mySql_2 = "select course.cname as '课程名',sc.score as '分数' from sc,course,sections where " +
                    "sc.secnum=sections.secnum and course.cnum=sections.cnum and sc.snum='" + textBox1.Text + "'";
                SqlDataAdapter myAdapter_2 = new SqlDataAdapter(mySql_2, myConnection);
                myAdapter_2.Fill(myDataset, "scores");
                dataGridView1.DataSource = myDataset.Tables["scores"];
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            myConnection.Close();
            this.Close();
        }
    }
}
