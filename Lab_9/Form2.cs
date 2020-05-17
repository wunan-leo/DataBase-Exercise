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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        static SqlConnection myConnection = new SqlConnection("Initial Catalog=university;Data Source=(local);Integrated Security=True;");

        BindingSource mybind_1 = new BindingSource();
        BindingSource mybind_2 = new BindingSource();

        private void button1_Click(object sender, EventArgs e)
        {
            String stu_num=textBox1.Text;
            String mySql_1 = "select snum,sname from student where snum='" + stu_num + "'";
            SqlDataAdapter myAdapter_1 = new SqlDataAdapter(mySql_1, myConnection);
            DataSet myDataset = new DataSet();
            myAdapter_1.Fill(myDataset, "stu");
            mybind_1.DataSource = myDataset;
            mybind_1.DataMember = "stu";

            if (myDataset.Tables.Count == 0)
            {
                MessageBox.Show("该学生信息不存在!");
            }
            else
            {
                textBox2.DataBindings.Add(new Binding("Text",mybind_1,"snum",true));
                textBox3.DataBindings.Add(new Binding("Text", mybind_1, "sname", true));
                String mySql_2 = "select course.cname as '课程名',sc.score as '分数' from sc,course,sections where " +
                   "sc.secnum=sections.secnum and course.cnum=sections.cnum and sc.snum='" + textBox1.Text + "'";
                SqlDataAdapter myAdapter_2 = new SqlDataAdapter(mySql_2, myConnection);
                myAdapter_2.Fill(myDataset, "scores");
                mybind_2.DataSource = myDataset;
                mybind_2.DataMember = "scores";

                textBox4.DataBindings.Add(new Binding("Text", mybind_2, "课程名", true));
                textBox5.DataBindings.Add(new Binding("Text", mybind_2, "分数", true));
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            mybind_2.MoveFirst();

        }

        private void Form2_Load(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            mybind_2.MovePrevious();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            mybind_2.MoveNext();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            mybind_2.MoveLast();
        }
    }
}
